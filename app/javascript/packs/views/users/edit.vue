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
      v-model="user.name"
      :counter="20"
      :rules="rules.name"
      label="Name"
      :placeholder="auth.current_user.name"
      required
    ></v-text-field>
    <v-textarea
      id="comment_content"
      v-model="user.profile"
      :counter="140"
      :rules="rules.profile"
      label="Profile"
      :placeholder="auth.current_user.profile"
      auto-grow
    ></v-textarea>
    <v-btn :disabled="!valid" color="success" class="mr-4" @click="updateUser">
      更新
    </v-btn>
  </v-form>
</template>

<script>
import axios from 'axios'
import store from '../../store.js'

export default {
  data: function () {
    return {
      auth: store.state.auth,
      user: {
        name: '',
        profile: '',
      },
      errors: '',
      valid: true,
      rules: {
        name: [
          (v) => !!v || 'Name is required',
          (v) =>
            (v && v.length <= 10) || 'Name must be less than 10 characters',
        ],
        profile: [
          (v) => v.length <= 140 || 'Profile must be less than 140 characters',
        ],
      },
    }
  },
  methods: {
    updateUser: function () {
      axios
        .put('/api/v1/users', this.user)
        .then((response) => {
          store.refresh()
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
</style>
