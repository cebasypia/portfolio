<template>
  <v-card class="align-center mx-auto">
    <div class="information">
      <div class="created_at">{{ comment.created_at }}にコメント</div>
      <v-list-item v-if="display_user">
        <UserImage :size="size" :user="comment.user"></UserImage>
        <v-list-item-content>
          <v-list-item-title>
            {{ comment.user.name }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </div>
    <v-card-text>{{ comment.content }}</v-card-text>
    <div v-if="display_tweet" class="tweet-card-container">
      <TweetCardMini class="tweet-card" :tweet="comment.tweet"></TweetCardMini>
    </div>
    <v-card-actions v-if="is_mime">
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
import store from '../../store.js'

import UserImage from '../../components/userImage.vue'
import TweetCardMini from '../../components/tweetCardMini.vue'

export default {
  props: {
    comment: Object,
    size: {
      type: Number,
      default: 73,
    },
    display_user: {
      type: Boolean,
      default: true,
    },
    display_tweet: {
      type: Boolean,
      default: true,
    },
  },
  data: function () {
    return {
      auth: store.state.auth,
    }
  },
  methods: {
    destroyComment(id) {
      axios.delete(`/api/v1/comments/${id}`).then(() => {
        this.$emit('update')
      })
    },
  },
  computed: {
    is_mime: function () {
      if (this.auth.logged_in) {
        return this.comment.user.id === this.auth.current_user.id
      } else {
        return false
      }
    },
  },
  components: {
    UserImage,
    TweetCardMini,
  },
}
</script>

<style scoped>
.information {
  position: relative;
}
.created_at {
  position: absolute;
  right: 1rem;
  font-size: 0.8rem;
  color: rgba(0, 0, 0, 0.6);
}

.tweet-card {
  box-shadow: initial !important;
  border-color: rgba(0, 172, 237, 1);
  border-style: solid;
}
.tweet-card-container {
  padding: 1rem;
}
</style>
