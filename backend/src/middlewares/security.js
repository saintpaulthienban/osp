const cors = require("cors");
const helmet = require("helmet");
const rateLimit = require("express-rate-limit");
// const mongoSanitize = require("express-mongo-sanitize");
// const xssClean = require("xss-clean");
// const hpp = require("hpp");

const FIFTEEN_MINUTES_MS = 15 * 60 * 1000;

const parseAllowedOrigins = () => {
  const { CORS_ORIGIN } = process.env;
  const fromEnv = CORS_ORIGIN
    ? CORS_ORIGIN.split(",").map((o) => o.trim()).filter(Boolean)
    : [];

  // Also allow common frontend env vars to be picked up automatically
  const extras = [
    process.env.FRONTEND_URL,
    process.env.CLIENT_URL,
    process.env.FRONTEND_ORIGIN,
    process.env.VERCEL_URL && `https://${process.env.VERCEL_URL}`,
    process.env.NETLIFY_URL && `https://${process.env.NETLIFY_URL}`,
  ].filter(Boolean);

  return Array.from(new Set([...fromEnv, ...extras]));
};

const buildCorsOptions = () => {
  const allowedOrigins = parseAllowedOrigins();
  const allowAllOrigins = allowedOrigins.includes("*");

  console.log('CORS allowed origins:', allowedOrigins);

  // Development localhost origins
  const localhostOrigins = [
    "http://localhost:3000",
    "http://localhost:5173",
    "http://localhost:5174",
    "http://127.0.0.1:3000",
    "http://127.0.0.1:5173",
    "http://127.0.0.1:5174",
  ];

  return {
    origin: (origin, callback) => {
      // Allow requests with no origin (mobile apps, Postman, server-to-server)
      if (!origin) {
        return callback(null, true);
      }

      if (allowAllOrigins) {
        return callback(null, true);
      }

      if (allowedOrigins.includes(origin)) {
        return callback(null, true);
      }

      // Allow localhost in development for easier testing
      if (localhostOrigins.includes(origin)) {
        console.log(`✅ CORS allowing development origin: ${origin}`);
        return callback(null, true);
      }

      console.warn(`⚠️ CORS blocked request from origin: ${origin}`);
      return callback(new Error("Not allowed by CORS"));
    },
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
    allowedHeaders: [
      "Content-Type",
      "Authorization",
      "Accept",
      "X-Requested-With",
      "X-CSRF-Token",
    ],
    credentials: true,
    optionsSuccessStatus: 204,
  };
};

const buildHelmetConfig = () => {
  const allowedOrigins = parseAllowedOrigins();
  const allowAllOrigins = allowedOrigins.includes("*");
  const connectSrc = allowAllOrigins ? ["*"] : ["'self'", ...allowedOrigins];

  return {
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        scriptSrc: ["'self'", "'unsafe-inline'"],
        styleSrc: ["'self'", "'unsafe-inline'"],
        imgSrc: ["'self'", "data:", "https:", "http://localhost:5000"],
        connectSrc: ["'self'", "http://localhost:5000", ...connectSrc],
        objectSrc: ["'none'"],
        frameAncestors: ["'none'"],
        upgradeInsecureRequests: [],
      },
    },
    crossOriginEmbedderPolicy: false,
    crossOriginResourcePolicy: { policy: "cross-origin" },
  };
};

const generalRateLimiter = rateLimit({
  windowMs: FIFTEEN_MINUTES_MS,
  max: process.env.NODE_ENV === "production" ? 500 : 1000, // Increased limit for production Railway deployment
  standardHeaders: true,
  legacyHeaders: false,
  skip: (req) => {
    // Skip rate limiting for health checks
    return req.path === "/" || req.path === "/healthz";
  },
  message: {
    success: false,
    message: "Too many requests, please try again later.",
  },
});

const loginRateLimiter = rateLimit({
  windowMs: FIFTEEN_MINUTES_MS,
  max: process.env.NODE_ENV === "production" ? 5 : 50, // Higher limit for development
  standardHeaders: true,
  legacyHeaders: false,
  message: {
    success: false,
    message: "Too many login attempts, please wait 15 minutes.",
  },
});

const applySecurityMiddlewares = (app) => {
  const corsOptions = buildCorsOptions();
  const helmetConfig = buildHelmetConfig();

  app.use(cors(corsOptions));
  app.use(helmet(helmetConfig));
  // app.use(hpp());
  // app.use(mongoSanitize());
  // app.use(xssClean());

  // Only apply rate limiting in production
  if (process.env.NODE_ENV === "production") {
    app.use(generalRateLimiter);
    app.use("/api/auth/login", loginRateLimiter);
  }
};

module.exports = {
  applySecurityMiddlewares,
  generalRateLimiter,
  loginRateLimiter,
};
