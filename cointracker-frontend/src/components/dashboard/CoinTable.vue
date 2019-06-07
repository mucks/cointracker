<template>
  <div style="overflow: hidden">
    <h2 align="center"> Total: {{ '$' + total.toFixed(2) }}</h2>
    <div class="table-responsive">
      <table class="table table-striped">
        <thead>
          <tr>
            <th>Name</th>
            <th>Amount</th>
            <th>Price</th>
            <th>Total</th>
            <th>Actions</th>
          </tr>
        </thead>
          <transition-group name="slide" tag="tbody">
          <tr v-for="(coin, i) in coins" :key="i" class="table-row">
            <td>{{ coin.cmc_id}}</td>
            <td>
              <div v-if="coin.edit">
                <input class="form-control" v-model="coin.amount">
              </div>
              <div v-else>
                <span>{{ coin.amount }}</span>
              </div>
            </td>
            <td>{{ '$' + coin.price.toFixed(2) }}</td>
            <td>{{ '$' + coin.total.toFixed(2) }}</td>
            <td>
              <div id="edit" v-if="coin.edit">
                <button @click="save(i)" class="btn btn-success">
                  <i class="fas fa-check"></i>
                </button>
                <button @click="cancel(i)" class="btn btn-default">
                  <i class="fas fa-times"></i>
                </button>
              </div>
              <div v-else>
                <button @click="edit(i)" class="btn btn-info">
                  <i class="fas fa-edit"></i>
                </button>
                <button @click="remove(i)" class="btn btn-danger">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </td>
          </tr>
          </transition-group>
      </table>
    </div>
  </div>
</template>

<style scoped>
.table {
  table-layout: fixed;
}



.slide-leave-active,
.slide-enter-active {
  transition: 1s;
}
.slide-enter {
  transform: translate(100%, 0);
}
.slide-leave-to {
  transform: translate(-100%, 0);
}
</style>

<script>
import axios from 'axios'
import auth from '../../services/auth.js'
import { eventBus } from '../../main.js'
export default {
  data: () => {
    return {
      coins: [],
      total: 0
    }
  },
  created() {
    let vm = this
    vm.get_coins()
    vm.get_total()
    setInterval(() => {
      vm.update_coins()
      vm.get_total()
    }, 60000)


    eventBus.$on('coinAdded', id => {
      axios.get('/api/get-coin?id='+id,
        {
          headers: { 'x-access-token': auth.getToken() }
        }
      )
      .then(response => {
        console.log(response)
        if(response.data.status == 'success') {
          vm.coins.push(response.data['coin'])
          vm.total += response.data['coin'].total
        } 
      })
      .then(error => {
        console.log(error)
      })

    })
  },
  methods: {
    update_coins() {
      let vm = this;
      axios.get('/api/get-coins',
        {
          headers: { 'x-access-token': auth.getToken() }
        }
      )
      .then(response => {
        console.log(response)
        if(response.data.status == 'success') {
          for (let i=0; i< vm.coins.length; i++) {
            vm.coins[i].price = response.data['coins'][i].price
            vm.coins[i].total = response.data['coins'][i].total
          }
        } 
      })
      .then(error => {
        console.log(error)
      })

    },
    get_total() {
      let vm = this;
      console.log('happens')
      axios.get('/api/get-total',
        {
          headers: { 'x-access-token': auth.getToken() }
        }
      )
      .then(response => {
        console.log(response)
        if(response.data.status == 'success') {
          vm.total = response.data['total']
        } 
      })
      .then(error => {
        console.log(error)
      })
    },
    edit(i) {
      this.coin_edit(i, true)
      this.coins[i].original_amount = this.coins[i].amount
    },
    save(i) {
      let vm = this
      axios.post('/api/update-coin',
        {
          id: vm.coins[i]._id,
          amount: vm.coins[i].amount
        },
        {
          headers: { 'x-access-token': auth.getToken() }
        }
      )
      .then(response => {
        console.log(response)
        if(response.data.status == 'success') {
          vm.total += (vm.coins[i].amount - vm.coins[i].original_amount) * vm.coins[i].price
          vm.coins[i].total = vm.coins[i].amount * vm.coins[i].price
          vm.coin_edit(i, false)
        } else {
          eventBus.$emit('showStatus', response.data)
       }
      })
      .then(error => {
        console.log(error)
      })
        
    },
    cancel(i) {
      this.coin_edit(i, false)
      this.coins[i].amount = this.coins[i].original_amount
    },
    coin_edit(i, mybool) {
      this.coins[i].edit = mybool
      this.coins.push({})
      this.coins.splice(this.coins.length -1, 1)
    },
    remove(i) {
      let vm = this;
      axios.post('/api/remove-coin',
        {
          id: vm.coins[i]._id,
        },
        {
          headers: { 'x-access-token': auth.getToken() }
        }
      )
      .then(response => {
        console.log(response)
        if(response.data.status == 'success') {
          vm.total -= vm.coins[i].total
          vm.coins.splice(i, 1)
        } else {
          eventBus.$emit('showStatus', response.data)
        }
      })
      .then(error => {
        console.log(error)
      })
    },
    get_coins() {
      let vm = this;
      axios.get('/api/get-coins',
        {
          headers: { 'x-access-token': auth.getToken() }
        }
      )
      .then(response => {
        console.log(response)
        if(response.data.status == 'success') {
          vm.coins = response.data['coins']
        } 
      })
      .then(error => {
        console.log(error)
      })

    },
  }
}
</script>
  
