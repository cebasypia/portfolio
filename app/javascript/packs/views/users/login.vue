<template>
  <v-form ref="form" v-model="valid" lazy-validation>
    <v-alert
      v-if="errors.length != 0"
      border="bottom"
      colored-border
      type="warning"
      elevation="2"
    >
      <ul v-for="error in errors" :key="error">
        <li>
          <font color="red">{{ error }}</font>
        </li>
      </ul>
    </v-alert>
    <v-text-field
      v-model="session.email"
      :rules="rules.email"
      label="E-mail"
      required
    ></v-text-field>
    <v-text-field
      v-model="session.password"
      :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
      :rules="rules.password"
      :type="show1 ? 'text' : 'password'"
      label="Password"
      counter
      @click:append="show1 = !show1"
    ></v-text-field>
    <v-btn :disabled="!valid" color="success" class="mr-4" @click="login"
      >Log in</v-btn
    >
  </v-form>
</template>

<script>
import axios from 'axios'
import store from '../../store.js'

export default {
  data: function () {
    return {
      session: {
        email: '',
        password: '',
      },
      errors: '',
      valid: true,
      show1: false,
      rules: {
        email: [
          (v) => !!v || 'E-mail is required',
          (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
        ],
        password: [(v) => v.length >= 6 || 'Min 6 characters'],
      },
      prevRoute: null,
    }
  },
  methods: {
    login: function () {
      axios
        .post('/api/v1/login', this.session)
        .then(() => {
          store.refresh()
          this.$router.push({ path: this.prevRoute.path })
        })
        .catch((error) => {
          console.error(error)
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors
          }
        })
    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      vm.prevRoute = from
    })
  },
}
</script>

<style scoped>
ul {
  list-style: none;
  list-style: none;
}
</style>
