<template>
  <v-card>
    <v-list-item two-line>
      <v-list-item-avatar size="73" color="grey">
        <v-img :src="user.profile_image_url"></v-img>
      </v-list-item-avatar>
      <v-list-item-content>
        <v-list-item-title>{{ user.name }}</v-list-item-title>
        <v-list-item-subtitle>@{{ user.screen_name }}</v-list-item-subtitle>
      </v-list-item-content>
    </v-list-item>
    <v-card-text>{{ user.description }}</v-card-text>
    <v-row justify="space-around" fill-height class="info-row">
      <v-col cols="auto">
        <a :href="user.uri" target="_blank">
          <v-icon class="icon-twitter">mdi-twitter</v-icon>
        </a>
      </v-col>
      <v-col cols="auto"> フォロワー数: {{ user.followers_count }} </v-col>
      <v-col cols="auto"> フレンド数: {{ user.friends_count }} </v-col>
    </v-row>
  </v-card>
</template>
<script>
export default {
  props: ['user'],
}
</script>

<style scoped>
a {
  text-decoration: none;
}
.info-row {
  font-size: 12px;
  color: rgba(0, 0, 0, 0.6);
}
.icon-twitter {
  color: rgb(29, 161, 242);
}
</style>
