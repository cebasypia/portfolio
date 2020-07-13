<template>
  <v-container fluid>
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
        v-model="user.name"
        :counter="20"
        :rules="rules.name"
        label="Name"
        required
      ></v-text-field>
      <v-text-field
        v-model="user.email"
        type="email"
        :rules="rules.email"
        label="E-mail"
        required
      ></v-text-field>
      <v-text-field
        v-model="user.password"
        :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
        :rules="rules.password"
        :type="show1 ? 'text' : 'password'"
        label="Password"
        counter
        @click:append="show1 = !show1"
      ></v-text-field>
      <v-text-field
        v-model="user.password_confirmation"
        :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
        :rules="rules.password_confirmation"
        :type="show2 ? 'text' : 'password'"
        label="Password confirmation"
        counter
        @click:append="show2 = !show2"
      ></v-text-field>
      <div class="text-right">
        <v-btn
          :disabled="!valid"
          color="primary"
          class="mr-4 mt-2"
          @click="createUser"
        >
          登録
        </v-btn>
      </div>
    </v-form>
  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  data: function () {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
      errors: '',
      valid: true,
      show1: false,
      show2: false,
      rules: {
        name: [
          (v) => !!v || 'Name is required',
          (v) =>
            (v && v.length <= 10) || 'Name must be less than 10 characters',
        ],
        email: [
          (v) => !!v || 'E-mail is required',
          (v) => /.+@.+\..+/.test(v) || 'E-mail must be valid',
        ],
        password: [(v) => v.length >= 6 || 'Min 6 characters'],
        password_confirmation: [
          (v) => v.length >= 6 || 'Min 6 characters',
          (v) => v === this.user.password || 'Password must match',
        ],
      },
    }
  },
  methods: {
    createUser: function () {
      axios
        .post('/api/v1/users', this.user)
        .then((response) => {
          this.$store.dispatch('resetAuth')
          this.$router.push({
            name: 'UsersShowPage',
            params: { id: response.data.id },
          })
        })
        .catch((error) => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors
          }
        })
    },
  },
}
</script>

<style scoped>
ul {
  list-style: none;
}
::v-deep .v-form {
  margin: 0.5rem !important;
}
</style>
