// Test update journey API
require('dotenv').config();
const axios = require('axios');

const BASE_URL = process.env.BACKEND_URL || 'http://localhost:5001';

async function testUpdateJourney() {
  try {
    // First, login to get token
    console.log('1. Logging in...');
    const loginResponse = await axios.post(`${BASE_URL}/api/auth/login`, {
      username: 'admin',
      password: 'Admin123!'
    });
    
    const token = loginResponse.data.token;
    console.log('✓ Login successful');
    
    // Get list of journeys to find one to update
    console.log('\n2. Getting journey list...');
    const listResponse = await axios.get(`${BASE_URL}/api/vocation-journeys`, {
      headers: { Authorization: `Bearer ${token}` }
    });
    
    if (!listResponse.data.data || listResponse.data.data.length === 0) {
      console.log('❌ No journeys found to update');
      return;
    }
    
    const firstJourney = listResponse.data.data[0];
    console.log('✓ Found journey:', {
      id: firstJourney.id,
      sister_name: firstJourney.sister_name,
      stage: firstJourney.stage
    });
    
    // Try to update it
    console.log('\n3. Updating journey...');
    const updatePayload = {
      notes: `Updated at ${new Date().toISOString()} - Test update`
    };
    
    console.log('Sending PUT request to:', `${BASE_URL}/api/vocation-journeys/${firstJourney.id}`);
    console.log('Payload:', updatePayload);
    
    const updateResponse = await axios.put(
      `${BASE_URL}/api/vocation-journeys/${firstJourney.id}`,
      updatePayload,
      {
        headers: { Authorization: `Bearer ${token}` }
      }
    );
    
    console.log('✓ Update successful!');
    console.log('Response:', updateResponse.data);
    
    // Verify the update
    console.log('\n4. Verifying update...');
    const verifyResponse = await axios.get(
      `${BASE_URL}/api/vocation-journeys/${firstJourney.id}`,
      {
        headers: { Authorization: `Bearer ${token}` }
      }
    );
    
    console.log('✓ Verification result:');
    console.log('Notes field:', verifyResponse.data.notes);
    
  } catch (error) {
    console.error('❌ Error:', error.response?.data || error.message);
    if (error.response) {
      console.error('Status:', error.response.status);
      console.error('Headers:', error.response.headers);
    }
  }
}

testUpdateJourney();
