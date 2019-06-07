export default { 
  isAuthenticated() {
    return window.localStorage.getItem('token') != null
  },
  setToken(token) {
    window.localStorage.setItem('token', token)
  },
  getToken() {
    if (this.isAuthenticated()) {
      return window.localStorage.getItem('token')
    }
    return false
  },
  removeToken() {
    window.localStorage.removeItem('token')
  }
}
