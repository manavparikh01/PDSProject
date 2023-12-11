import logo from './logo.svg';
import './App.css';
import {BrowserRouter, Routes, Route} from "react-router-dom";
import SignInPage from './pages/signin';
import RegisterPage from './pages/register';

function App() {
  return (
    <BrowserRouter>
       <div >
         <Routes>

           <Route path="/" element={<SignInPage />} />
           <Route path="/register" element={<RegisterPage />} />
           {/* <Route path="/admin" element={<AdminPage />} />
           <Route path="/helperbot" element={<HelperBot />} />
           <Route path="/feedback" element={<FeedbackForm />} /> */}
         </Routes>
         </div>
       </BrowserRouter>
  );
}

export default App;