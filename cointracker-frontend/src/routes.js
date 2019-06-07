import Login from './components/user/Login.vue'
import Signup from './components/user/Signup.vue'
import Dashboard from './components/dashboard/Dashboard.vue'

export const routes = [
  { path: '', component: Dashboard },
  { path: '/login', component: Login },
  { path: '/signup', component: Signup }
]
