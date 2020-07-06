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
  mounted() {
    axios
      .post(`/api/v1/tweets/is_read`, { tweet_id: this.$route.params.id })
      .then((response) => (this.is_read = response.data))
  },
  methods: {
    createRead: function () {
      axios
        .post(`/api/v1/reads`, {
          tweet_id: this.$route.params.id,
        })
        .then((response) => (this.is_read = response.data))
    },
    destroyRead: function () {
      axios
        .delete(`/api/v1/reads/${this.$route.params.id}`)
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
