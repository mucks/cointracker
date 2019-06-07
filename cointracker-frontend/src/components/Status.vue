<template>
  <div style="overflow-y: hidden; position: relative; height: 3rem">
    <transition name="slide">
      <div v-if="status == 'success'" class="alert ct-alert alert-success">
        {{ message }}
      </div>
    </transition>
    <transition name="slide">
      <div v-if="status == 'fail'" class="alert ct-alert alert-danger">
        {{ message }}
      </div>
    </transition>
  </div>
</template>

<script>
import { eventBus } from '../main.js'
export default {
  data: () => {
    return {
      status: '',
      message: ''
    }
  },
  created() {
    const vm = this
    eventBus.$on('showStatus', data => {
      console.log(data)
      vm.status = data.status
      vm.message = data.message
      setTimeout( () => {
        vm.status = 'done'
      }, 2000)
    })
  }

}
</script>
 

<style scoped>
.alert {
  padding-top: .3rem;
  padding-bottom: .3rem;
}
.ct-alert {
  width: 100%;
  position: absolute;
}
.slide-leave-active,
.slide-enter-active {
  transition: 1s;
}
.slide-enter {
  transform: translate(0, -100%);
}
.slide-leave-to {
  transform: translate(0, -100%);
}
</style>
