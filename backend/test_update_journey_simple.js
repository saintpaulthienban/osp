// Test update journey API - simple version using fetch
const https = require('https');

const RAILWAY_URL = 'https://01-hoi-dong-osp-production.up.railway.app';

async function makeRequest(method, path, token, body = null) {
  return new Promise((resolve, reject) => {
    const url = new URL(path, RAILWAY_URL);
    const options = {
      method,
      headers: {
        'Content-Type': 'application/json',
      }
    };
    
    if (token) {
      options.headers['Authorization'] = `Bearer ${token}`;
    }
    
    const req = https.request(url, options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          resolve({
            status: res.statusCode,
            data: JSON.parse(data),
            headers: res.headers
          });
        } catch (e) {
          resolve({ status: res.statusCode, data, headers: res.headers });
        }
      });
    });
    
    req.on('error', reject);
    if (body) req.write(JSON.stringify(body));
    req.end();
  });
}

async function test() {
  try {
    // 1. Login
    console.log('1. Logging in to Railway backend...');
    const login = await makeRequest('POST', '/api/auth/login', null, {
      username: 'admin',
      password: 'Admin123!'
    });
    
    if (login.status !== 200) {
      console.log('❌ Login failed:', login.data);
      return;
    }
    
    const token = login.data.token;
    console.log('✓ Login successful');
    
    // 2. Get journey list
    console.log('\n2. Getting journey list...');
    const list = await makeRequest('GET', '/api/vocation-journeys?limit=1', token);
    
    if (list.status !== 200 || !list.data.data || list.data.data.length === 0) {
      console.log('❌ No journeys found');
      console.log('Response:', list);
      return;
    }
    
    const journey = list.data.data[0];
    console.log('✓ Found journey ID:', journey.id);
    
    // 3. Update journey
    console.log('\n3. Updating journey...');
    const updatePayload = {
      notes: `Test update from script at ${new Date().toISOString()}`
    };
    
    console.log(`Sending PUT to /api/vocation-journeys/${journey.id}`);
    const update = await makeRequest(
      'PUT',
      `/api/vocation-journeys/${journey.id}`,
      token,
      updatePayload
    );
    
    console.log('Update response status:', update.status);
    console.log('Update response:', JSON.stringify(update.data, null, 2));
    
    if (update.status === 200) {
      console.log('✓ Update successful!');
    } else {
      console.log('❌ Update failed');
    }
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

test();
