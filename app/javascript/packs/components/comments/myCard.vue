<template>
  <v-card class="align-center mx-auto">
    <v-card-text>{{ comment.content }}</v-card-text>
    <TweetCardMini class="tweetCard" :tweet="comment.tweet"></TweetCardMini>
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
import TweetCardMini from '../../components/tweetCardMini.vue'

export default {
  props: ['comment'],
  methods: {
    destroyComment(id) {
      axios.delete(`/api/v1/comments/${id}`).then(() => this.$emit('update'))
    },
  },
  components: {
    TweetCardMini,
  },
}
</script>

<style scoped>
.tweetCard {
  box-shadow: initial !important;
  border-color: rgba(0, 172, 237, 1);
  border-style: solid;
}
.v-card {
  margin: 1rem;
}
</style>
