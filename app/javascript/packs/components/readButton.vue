<template>
  <div v-if="is_read">
    <v-icon @click="destroyRead">mdi-heart</v-icon>よんだ！
  </div>
  <div v-else>
    <v-icon @click="createRead">mdi-heart-outline</v-icon>よんだ！
  </div>
</template>
<script>
import axios from 'axios'

export default {
  props: ['tweet_id'],
  data: function () {
    return {
      is_read: false,
    }
  },
  asyncComputed: {
    is_read() {
      return axios
        .get(`/api/v1/reads/tweet/${this.tweet_id}`)
        .then((response) => (this.is_read = response.data))
    },
  },
  methods: {
    createRead: function () {
      axios
        .post(`/api/v1/reads`, {
          tweet_id: this.tweet_id,
        })
        .then((response) => (this.is_read = response.data))
    },
    destroyRead: function () {
      axios
        .delete(`/api/v1/reads/${this.tweet_id}`)
        .then((response) => (this.is_read = response.data))
    },
  },
}
</script>

<style scoped>
button {
  color: red !important;
}
</style>
