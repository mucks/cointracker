<template>
  <div>
    <ct-navbar></ct-navbar>
    <ct-status></ct-status>
    <div class="container">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import Navbar from './components/Navbar.vue'
import Status from './components/Status.vue'

export default {
  components: {
    'ct-navbar': Navbar,
    'ct-status': Status
  }
}
</script>
