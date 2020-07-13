<template>
  <v-card class="comment-card align-center mx-auto">
    <div class="information">
      <div class="created_at">{{ comment.created_at }}</div>
      <v-list-item v-if="display_user">
        <UserImage :size="size" :user="comment.user"></UserImage>
        <v-list-item-content>
          <v-list-item-title>
            {{ comment.user.name }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </div>
    <v-card-text class="text">{{ comment.content }}</v-card-text>
    <div v-if="display_tweet" class="tweet-card-container">
      <TweetCardMini class="tweet-card" :tweet="comment.tweet"></TweetCardMini>
    </div>
    <div v-if="is_mime" class="text-right">
      <v-btn class="ma-2" color="red" fab small dark>
        <v-icon @click="destroyComment(comment.id)">mdi-delete</v-icon>
      </v-btn>
    </div>
  </v-card>
</template>
<script>
import axios from 'axios'

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
    display_delete: {
      type: Boolean,
      default: true,
    },
  },

  methods: {
    destroyComment(id) {
      axios.delete(`/api/v1/comments/${id}`).then(() => {
        this.$emit('update')
      })
    },
  },
  computed: {
    auth() {
      return this.$store.state.auth
    },
    is_mime: function () {
      if (this.display_delete === false) return false
      if (this.$store.state.auth.logged_in) {
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
.comment-card {
  margin-bottom: 1rem;
}
.text {
  color: rgba(0, 0, 0, 0.87);
  user-select: text;
  white-space: pre-wrap;
}
.information {
  position: relative;
}
.created_at {
  position: absolute;
  right: 1rem;
  font-size: 0.8rem;
  color: rgba(0, 0, 0, 0.6);
}
.tweet-card-container {
  padding: 1rem;
}
.btn-delete {
  color: red;
}
</style>
