<template>
  <v-card>
    <v-list-item two-line>
      <v-list-item-avatar size="73" color="grey">
        <v-img
          :src="change_size(user.profile_image_url_https, 'bigger')"
        ></v-img>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title>{{ user.name }}</v-list-item-title>
        <v-list-item-subtitle>@{{ user.screen_name }}</v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>
    <v-card-text>{{ user.description }}</v-card-text>
  </v-card>
</template>
<script>
export default {
  props: ['user'],
  methods: {
    change_size(url, size) {
      return url.replace('normal', size)
    },
  },
}
</script>
