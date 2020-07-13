<template>
  <v-container fluid>
    <v-list-item>
      <UserImage :size="80" :user="user" :is_link="false"></UserImage>
      <a href="https://ja.gravatar.com/">by Gravator</a>
    </v-list-item>
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
      <v-textarea
        id="comment_content"
        v-model="user.profile"
        :counter="140"
        :rules="rules.profile"
        label="Profile"
        auto-grow
      ></v-textarea>
      <v-btn
        :disabled="!valid"
        color="success"
        class="mr-4"
        @click="updateUser"
      >
        更新
      </v-btn>
    </v-form>
  </v-container>
</template>

<script>
import axios from 'axios'

import UserImage from '../../components/userImage.vue'

export default {
  data: function () {
    return {
      user: {
        name: this.$store.state.auth.current_user.name,
        image_url: this.$store.state.auth.current_user.image_url,
        email: this.$store.state.auth.current_user.email,
        profile: this.$store.state.auth.current_user.profile,
      },
      errors: '',
      valid: true,
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
        profile: [
          (v) =>
            !v || v.length <= 140 || 'Profile must be less than 140 characters',
        ],
      },
    }
  },
  methods: {
    updateUser: function () {
      axios
        .put('/api/v1/users', this.user)
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
  components: {
    UserImage,
  },
}
</script>

<style scoped>
ul {
  list-style: none;
}
::v-deep .v-list-item {
  align-items: flex-end;
  justify-content: center;
}
a {
  font-size: 0.8rem;
}
</style>
