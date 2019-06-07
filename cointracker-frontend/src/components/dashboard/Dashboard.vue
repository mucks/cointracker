<template>
  <div v-if="isAuthenticated">
    <ct-coin-add></ct-coin-add>
    <hr>
    <ct-coin-table></ct-coin-table>
  </div>
  <div align="center" v-else>
    <h3>Signup or Login to continue</h3>
    <router-link class="btn btn-success" :to="'signup'">
      <i class="fas fa-user-plus"></i> Sign up 
    </router-link>
    <router-link class="btn btn-info" :to="'login'">
      <i class="fas fa-sign-in-alt"></i> Login
    </router-link>
  </div>
</template>

<script>
import auth from '../../services/auth.js'
import { eventBus } from '../../main.js'
import CoinAdd from './CoinAdd.vue'
import CoinTable from './CoinTable.vue'
export default {
  data: () => {
    return {
      isAuthenticated: auth.isAuthenticated()
    }
  },
  components: {
    'ct-coin-add': CoinAdd,
    'ct-coin-table': CoinTable
  },
  created() {
    eventBus.$on('authChange', (data) => {
      this.isAuthenticated = data
    })
  }

}
</script>
