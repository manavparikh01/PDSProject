import logo from './logo.svg';
import './App.css';
import {BrowserRouter, Routes, Route} from "react-router-dom";
import SignInPage from './pages/signin';
import RegisterPage from './pages/register';
import Dashboard from './pages/dasdboard';
import { CustomerProvider } from './customerContext';

function App() {
  return (
    <BrowserRouter>
       <div >
        <CustomerProvider>
         <Routes>

           <Route path="/" element={<SignInPage />} />
           <Route path="/register" element={<RegisterPage />} />
           <Route path="dashboard" element={<Dashboard />} />
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
