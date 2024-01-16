// api.ts
import axios, { AxiosInstance, AxiosResponse } from 'axios';

const api: AxiosInstance = axios.create({
  baseURL: 'https://renlab.sdsc.edu', // Replace with your API base URL
  timeout: 5000, // Set a timeout for requests
});

// Example API call function
export const postData = async (data:{ name: string; label: string; value: string; }[]): Promise<AxiosResponse> => {
  try {
    let formData = new FormData();
    formData.append('json', JSON.stringify(data));
    const response = await api.post('/renlab_docker/uploader.php',
      formData, { headers: { 'Content-Type': 'multipart/form-data'}}
    );
    return response;
  } catch (error) {
    throw error;
  }
};

export const fetchData = async (): Promise<AxiosResponse> => {
try {
  const response = await api.get('/renlab_docker/uploader.php');
  return response;
} catch (error) {
  throw error;
}
};

export default api;