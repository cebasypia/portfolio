<template>
  <div>
    <v-app-bar app bottom color="amber darken-2" dark>
      <router-link v-bind:to="{ name: 'RecordsIndexPage' }">
        <v-icon>mdi-school</v-icon>
      </router-link>
      <v-spacer></v-spacer>

      <router-link v-bind:to="{ name: 'TweetsIndexPage' }">
        <v-icon>mdi-home</v-icon>
      </router-link>

      <v-spacer></v-spacer>

      <router-link v-bind:to="{ name: 'TweetsSearchPage' }">
        <v-icon>mdi-magnify</v-icon>
      </router-link>
    </v-app-bar>
  </div>
</template>

<script></script>

<style scoped>
a {
  text-decoration: none;
}
</style>
