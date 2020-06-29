<template>
  <form @submit.prevent="createUser">
    <div v-if="errors.length != 0">
      <ul v-for="error in errors" :key="error">
        <li><font color="red">{{ error }}</font></li>
      </ul>
    </div>
    <div>
      <label>Name</label>
      <input v-model="user.name" type="text">
    </div>
    <div>
      <label>Email</label>
      <input v-model="user.email" type="text">
    </div>
    <div>
      <label>Password</label>
      <input v-model="user.password" type="text">
    </div>
    <div>
      <label>Password Confirmation</label>
      <input v-model="user.password_confirmation" type="text">
    </div>
    <button type="submit">Commit</button>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      },
      errors: ''
    }
  },
  methods: {
    createUser: function() {
      axios
        .post('/api/v1/users', this.user)
        .then(response => {
          let user = response.data;
          this.$router.push({ name: 'UsersShowPage', params: { id: user.id } });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>

<style scoped>
</style>