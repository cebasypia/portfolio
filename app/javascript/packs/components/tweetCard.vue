<template>
  <v-card>
    <v-list-item two-line>
      <v-list-item-avatar size="73" color="grey">
        <v-img
          :src="change_size(tweet.user.profile_image_url_https, '_bigger')"
        ></v-img>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-subtitle>{{ tweet.created_at }}</v-list-item-subtitle>
        <v-list-item-title>{{ tweet.user.name }}</v-list-item-title>
      </v-list-item-content>
    </v-list-item>
    <v-card-text>{{ tweet.full_text }}</v-card-text>
  </v-card>
</template>
<script>
export default {
  props: ['tweet'],
  methods: {
    change_size(url, size) {
      return url.replace('_normal', size)
    },
  },
}
</script>
