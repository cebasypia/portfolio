<template>
  <v-container fluid>
    <userCard :user="user"></userCard>
  </v-container>
</template>

<script>
import axios from 'axios'
import UserCard from '../../components/userCard.vue'

export default {
  data: function () {
    return {
      user: [],
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/user/${this.$route.params.id}`)
      .then((response) => (this.user = response.data))
  },
  components: {
    UserCard,
  },
}
</script>

<style scoped></style>
