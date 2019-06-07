<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <router-link class="navbar-brand" :to="'/'">Dashboard</router-link>
    <button class="navbar-toggler"
            type="button"
            data-toggle="collapse"
            data-target="#navbarNav"
            aria-controls="navbarSupportedContent" 
            aria-expanded="false" 
            aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="nav navbar-nav mr-auto navbar-right">
        <li v-if="isAuthenticated" class="nav-item">
          <a class="nav-link" href="#" @click="logout">
            <i class="fas fa-sign-out-alt"></i> Log out
          </a>
        </li>
        <li id="settings" v-if="isAuthenticated" class="nav-item">
          <router-link class="nav-link" :to="'settings'">Settings</router-link>
        </li>
        <li v-if="!isAuthenticated" class="nav-item">
          <router-link class="nav-link" :to="'signup'">
            <i class="fas fa-user-plus"></i> Sign up</router-link>
        </li>
        <li v-if="!isAuthenticated" class="nav-item">
          <router-link class="nav-link" :to="'login'">
            <i class="fas fa-sign-in-alt"></i> Login</router-link>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
  import auth from '../services/auth.js'
  import { eventBus } from '../main.js'
  export default {
    data: () => {
      return {
        isAuthenticated: auth.isAuthenticated()
      }
    },
    methods: {
      logout() {
        auth.removeToken()
        eventBus.$emit("authChange", false)
      }
    },
    created() {
      eventBus.$on('authChange', (data) => {
        this.isAuthenticated = data
      })
    }
  }
</script>
