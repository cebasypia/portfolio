<template>
  <v-card>
    <v-list-item two-line>
      <v-list-item-avatar size="73" color="grey">
        <router-link
          v-bind:to="{
            name: 'TweetsUserPage',
            params: { id: tweet.user.id_str },
          }"
        >
          <v-img
            :src="change_size(tweet.user.profile_image_url_https, 'bigger')"
          ></v-img>
        </router-link>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-subtitle>{{ tweet.created_at }}</v-list-item-subtitle>
        <router-link
          v-bind:to="{
            name: 'TweetsUserPage',
            params: { id: tweet.user.id_str },
          }"
        >
          <v-list-item-title class="user-name">
            {{ tweet.user.name }}
          </v-list-item-title>
        </router-link>
      </v-list-item-content>
    </v-list-item>
    <router-link
      v-bind:to="{
        name: 'TweetsShowPage',
        params: { id: tweet.id_str },
      }"
    >
      <v-card-text class="text">{{ tweet.full_text }}</v-card-text>
    </router-link>
    <v-row justify="space-around" fill-height class="info-row">
      <v-col cols="3">
        <v-icon class="icon-twitter">mdi-twitter</v-icon>
      </v-col>
      <v-col cols="3"> いいね: {{ tweet.favorite_count }} </v-col>
      <v-col cols="auto"> リツイート数: {{ tweet.retweet_count }} </v-col>
    </v-row>
  </v-card>
</template>
<script>
export default {
  props: ['tweet'],
  methods: {
    change_size(url, size) {
      return url.replace('normal', size)
    },
  },
}
</script>

<style scoped>
a {
  text-decoration: none;
}
.text {
  color: rgba(0, 0, 0, 0.87);
}
.user-name {
  color: rgba(0, 0, 0, 0.87);
}
.info-row {
  font-size: 12px;
  color: rgba(0, 0, 0, 0.6);
}
.icon-twitter {
  color: rgb(29, 161, 242);
}
</style>
