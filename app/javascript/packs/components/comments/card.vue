<template>
  <v-card class="align-center mx-auto">
    <v-card-text>{{ comment.content }}</v-card-text>
    <v-card-actions>
      <v-list-item class="grow">
        <v-row align="center" justify="end">
          <v-icon color="red" @click="destroyComment(comment.id)"
            >mdi-delete</v-icon
          >
        </v-row>
      </v-list-item>
    </v-card-actions>
  </v-card>
</template>
<script>
import axios from 'axios'
export default {
  props: ['comment'],
  data: function () {
    return {
      current_user: {},
    }
  },
  methods: {
    destroyComment(id) {
      axios
        .delete(`/api/v1/comments/${id}`, {
          tweet_id: this.$route.params.id,
        })
        .then(() => {
          this.$emit('update')
        })
    },
  },
  mounted() {
    axios
      .get(`/api/v1/current_user`)
      .then((response) => (this.current_user = response.data))
  },
}
</script>

<style scoped></style>
