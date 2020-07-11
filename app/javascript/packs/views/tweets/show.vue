<template>
  <v-container fluid>
    <TweetCard :tweet="tweet" :detail="true"></TweetCard>
    <CommentCard
      v-for="comment in comments"
      :comment="comment"
      :key="comment.id"
      :size="60"
      :display_tweet="false"
      @update="update"
    ></CommentCard>
    <CommentForm id="comment_form" @update="update"></CommentForm>
    <div id="bottom"></div>
  </v-container>
</template>

<script>
import TweetCard from '../../components/tweetCard.vue'
import CommentCard from '../../components/comments/card.vue'
import CommentForm from '../../components/comments/form.vue'

import axios from 'axios'
import store from '../../store.js'

export default {
  data: function () {
    return {
      tweet: {},
      comments: [],
      auth: store.state.auth,
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/${this.$route.params.id}`)
      .then((response) => (this.tweet = response.data))

    axios
      .get(`/api/v1/comments/tweet/${this.$route.params.id}`)
      .then((response) => (this.comments = response.data))
  },
  methods: {
    update() {
      axios
        .get(`/api/v1/comments/tweet/${this.$route.params.id}`)
        .then((response) => {
          this.comments = response.data
        })
    },
  },
  components: {
    TweetCard,
    CommentCard,
    CommentForm,
  },
}
</script>

<style scoped>
#comment_form {
  position: fixed;
  bottom: 56px;
  left: 0;
  width: 100%;
  background-color: whitesmoke;
}
#bottom {
  height: 70px;
}
</style>
