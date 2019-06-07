<template>
  <form>
    <div class="form-group">
      <label>Username</label>
      <input type="text"
             class="form-control"
             placeholder="Enter Username"
             v-model="username">
      <small class="form-text text-muted">{{ checkUsername() }}</small>
    </div>
    <div class="form-group">
      <label>Password</label>
      <input type="password"
             class="form-control"
             placeholder="Enter Password"
             v-model="password">
    </div>
    <div class="form-group">
      <input type="password"
             class="form-control"
             placeholder="Repeat Password"
             v-model="passwordRepeat">
      <small class="form-text text-muted">{{ checkPassword() }}</small>
    </div>
    <button class="btn btn-info" @click="signup" :disabled="!isValid()">Sign up</button>
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
    isValid() {
      return this.checkPassword() == this.checkUsername()
    },
    checkPassword() {
      if(this.password != this.passwordRepeat) {
        return "Passwords don't match"
      }
      if(this.password.length < 8) {
        return "The Password is too short, it needs to be atleast 8 characters long"
      }
      if(this.password.length > 20) {
        return "The Password is too long, it can be up to 20 characters long"
      }
      return ''
    },
    checkUsername() {
      if (this.username.length < 3) {
        return "The Username is too short, it needs to be atleast 3 characters long"
      }
      if (this.username.length > 20) {
        return "The Username is too long, it can be up to 20 characters long"
      }
      return ''
    },
    signup() {
      const vm = this;
      axios.post('/api/signup', {
        username: vm.username,
        password: vm.password
      })
      .then(response => {
        console.log(response)
        let data = response.data
        if (data.status == "success") {
          auth.setToken(data.token)
          eventBus.$emit("authChange", true)
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
