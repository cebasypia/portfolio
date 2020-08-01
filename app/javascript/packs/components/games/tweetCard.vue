<template>
  <v-card class="tweet-card">
    <v-list-item v-if="show_score" two-line>
      <v-list-item-content class="text-center">
        <v-col cols="4">
          <v-list-item-subtitle class="mb-1">正解</v-list-item-subtitle>
          <v-list-item-title>
            {{ tweet.score.correct_answer }}
          </v-list-item-title>
        </v-col>
        <v-col cols="4">
          <v-list-item-subtitle class="mb-1">回答</v-list-item-subtitle>
          <v-list-item-title>
            {{ tweet.score.answer }}
          </v-list-item-title>
        </v-col>
        <v-col cols="4">
          <v-list-item-subtitle class="mb-1">誤差</v-list-item-subtitle>
          <v-list-item-title>
            {{ tweet.score.diff }}
          </v-list-item-title>
        </v-col>
      </v-list-item-content>
    </v-list-item>
    <v-list-item v-if="show_user" two-line>
      <v-list-item-avatar size="42" color="grey">
        <v-img :src="tweet.user.profile_image_url"></v-img>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-subtitle>{{ tweet.created_at }}</v-list-item-subtitle>
        <v-list-item-title class="user-name">
          {{ tweet.user.name }}
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>
    <v-card-text class="text">{{ tweet.full_text }}</v-card-text>
    <div v-if="tweet.entities.media" class="img">
      <v-img :src="tweet.entities.media[0].media_url"></v-img>
    </div>
  </v-card>
</template>

<script>
export default {
  props: {
    tweet: {
      type: Object,
    },
    show_user: {
      type: Boolean,
      default: true,
    },
    show_score: {
      type: Boolean,
      default: false,
    },
  },
  computed: {},
  components: {},
}
</script>

<style scoped>
.tweet-card {
  margin-bottom: 1rem;
}
a {
  text-decoration: none;
}
.text {
  color: rgba(0, 0, 0, 0.87);
  user-select: text;
  white-space: pre-wrap;
}
::v-deep .v-image {
  margin: 0.5rem;
  border-radius: 5px;
}
.user-name {
  color: rgba(0, 0, 0, 0.87);
}
</style>
