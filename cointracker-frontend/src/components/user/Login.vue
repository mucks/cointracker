<template>
  <form>
    <div class="form-group">
      <label>Username</label>
      <input type="text"
             class="form-control"
             placeholder="Enter Username"
             v-model="username">
    </div>
    <div class="form-group">
      <label>Password</label>
      <input type="password"
             class="form-control"
             placeholder="Enter Password"
             v-model="password">
    </div>
    </div>
    <button class="btn btn-info" @click="login">Login</button>
  </form>
</template>

<script>
import axios from 'axios'
import auth from '../../services/auth.js'
import { eventBus } from '../../main.js'

export default {
  data: () => {
    return {
      username: '',
      password: '',
      passwordRepeat: ''
    }
  },
  methods: {
    login() {
      const vm = this;
      axios.post('/api/login', {
        username: vm.username,
        password: vm.password
      })
      .then(response => {
        console.log(response)
        let data = response.data
        eventBus.$emit('showStatus', data)
        if (data.status == "success") {
          auth.setToken(data.token)
          eventBus.$emit('authChange', true)
          vm.$router.push('/')
        } else {
          eventBus.$emit('showStatus', data)
        }
      })
      .catch(error => {
        console.log(error)
      })
    }
  }
}
</script>
