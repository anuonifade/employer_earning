import axios from 'axios';
import {BASE_URL} from '../constants/Index';

const token = document.querySelector('meta[name="csrf-token"]').content;

axios.defaults.baseURL = `${BASE_URL}`;
axios.defaults.headers.post['Content-Type'] = 'application/json';
axios.defaults.headers["Content-Type"] = "application/json";
axios.defaults.headers["X-CSRF-Token"] = token;
axios.defaults.headers.post["X-CSRF-Token"]
axios.defaults.timeout = 20000;

axios.interceptors.response.use((response) => {
  return response;
}, (error) => {
  return Promise.reject(error.response);
})

const Api = {
  fetchAllEmployers: async () => {
    try {
      const response = await axios.get('/employers');
      return response;
    } catch (error) {
      return error;
    }
  },
  fetchEmployer: async (id) => {
    try {
      const response = await axios.get(`/employers/${id}`);
      return response
    } catch (error) {
      return error;
    }
  },
  updateEmployer: async (employer_id, data) => {
    try {
      const response = await axios.put(`/employers/${employer_id}`, data);
      return response;
    } catch(error) {
      return error;
    }
  },
  deleteEmployer: async (employer_id) => {
    try {
      const response = await axios.delete(`/employers/${employer_id}`);
      return response;
    } catch(error) {
      return error;
    }
  },
  addEmployer: async (data) => {
    try {
      const response = await axios.post('/employers', data);
      return response;
    } catch(error) {
      return error;
    }
  },
  bulkEarningUpload: async (employerID, file) => {
    const formData = new FormData();
    formData.append("file", file, file.name);
    try {
      const response = await axios.post(`/employers/${employerID}/earnings`, formData);
      return response;
    } catch(error) {
      return error;
    }
  },
  fetchAllEarnings: async (employer_id) => {
    try {
      const response = await axios.get(`/employers/${employer_id}/earnings`);
      return response;
    } catch (error) {
      return error;
    }
  },
  fetchEarning: async (employer_id, id) => {
    try {
      const response = await axios.get(`/employers/${employer_id}/earnings/${id}`);
      return response
    } catch (error) {
      return error;
    }
  },
  updateEarning: async (employer_id, id, data) => {
    try {
      const response = await axios.put(`/employers/${employer_id}/earnings/${id}`, data);
      return response;
    } catch(error) {
      return error;
    }
  },
  deleteEarning: async (employer_id, id) => {
    try {
      const response = await axios.delete(`/employers/${employer_id}/earnings/${id}`);
      return response;
    } catch(error) {
      return error;
    }
  },
  addEarning: async (employer_id, data) => {
    try {
      const response = await axios.post(`/employers/${employer_id}/earnings`, data);
      return response;
    } catch(error) {
      return error;
    }
  }
}

export default Api;