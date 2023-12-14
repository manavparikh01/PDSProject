import logo from './logo.svg';
import './App.css';
import {BrowserRouter, Routes, Route} from "react-router-dom";
import SignInPage from './pages/signin';
import RegisterPage from './pages/register';
import Dashboard from './pages/dasdboard';
import Locations from './pages/serviceLocations';
import LocationForm from './pages/locationForm';
import Devices from './pages/devices';
import DeviceForm from './pages/deviceForm';
import { CustomerProvider } from './customerContext';

function App() {
  return (
    <BrowserRouter>
       <div >
        <CustomerProvider>
         <Routes>

           <Route path="/" element={<SignInPage />} />
           <Route path="/register" element={<RegisterPage />} />
           <Route path="/dashboard" element={<Dashboard />} />
           <Route path="/locations" element={<Locations />} />
           <Route path="/newlocation" element={<LocationForm />} />
           <Route path="/location/:locationID" element={<Devices />} />
           <Route path="/newdevice/:locationID" element={<DeviceForm />} />
           {/* <Route path="/admin" element={<AdminPage />} />
           <Route path="/helperbot" element={<HelperBot />} />
           <Route path="/feedback" element={<FeedbackForm />} /> */}
         </Routes>
         </CustomerProvider>
         </div>
       </BrowserRouter>
  );
}

export default App;
