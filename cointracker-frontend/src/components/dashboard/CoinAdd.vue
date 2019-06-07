<template>
  <form>
    <div class="row">
      <div class="col-md-12">
        <div class="input-group">
          <select v-model="cmc_id" class="form-control">
            <option v-for="option in options">
              {{ option }}
            </option>
          </select>
          <input placeholder="Enter Amount" v-model="amount" type="text" class="form-control">
          <div class="input-group-append">
            <button class="btn btn-success" @click="add()">
              <i class="fas fa-plus"></i> 
            </button>
          </div>
        </div>
      </div>
      <div class="col-md-2">
      </div>
    </div>
  </form>
</template>

<script>
import axios from 'axios'
import auth from '../../services/auth.js'
import { eventBus } from '../../main.js'
export default {
  data: () => {
    return {
      cmc_id: 'bitcoin',
      amount: '',
      options: []
    }
  },
  methods: {
    add() {
      let vm = this;
      axios.post('/api/add-coin',
        { 
          cmc_id: vm.cmc_id,
          amount: vm.amount
        },
        {
          headers: { 'x-access-token': auth.getToken() }
        }
      )
      .then(response => {
        console.log(response)
        if(response.data.status == 'success') {
          eventBus.$emit('coinAdded', response.data['id'])
        } else {
          eventBus.$emit('showStatus', response.data)
        }
      })
      .then(error => {
        console.log(error)
      })
    }
  },
  created() {
    let vm = this;
    axios.get('/api/cmc-ids')
    .then(response => {
      vm.options = response.data 
    })
    .then(error => {
      console.log(error)
    })
  }
}
</script>
