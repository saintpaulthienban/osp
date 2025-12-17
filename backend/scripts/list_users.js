const db = require('../config/database');

(async () => {
  const [users] = await db.execute(
    'SELECT id, username, full_name, is_admin, is_super_admin FROM users WHERE is_active = 1 ORDER BY username'
  );
  
  console.log('Active users:');
  users.forEach((u, i) => {
    const adminStatus = u.is_admin ? 'YES' : 'NO';
    const superStatus = u.is_super_admin ? 'YES' : 'NO';
    console.log(`${i+1}. ${u.username.padEnd(25)} (${(u.full_name || 'N/A').padEnd(20)}) - Admin: ${adminStatus}, Super: ${superStatus}`);
  });
  
  await db.end();
})();
