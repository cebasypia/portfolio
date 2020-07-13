<template>
  <v-btn v-if="is_read" class="ma-2 on" fab small>
    <v-icon @click="destroyRead">mdi-folder-heart</v-icon>
  </v-btn>
  <v-btn v-else class="ma-2 off" fab small>
    <v-icon @click="createRead">mdi-folder-heart-outline</v-icon>
  </v-btn>
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
.on {
  color: red;
}
.off {
  color: gray;
}
</style>
