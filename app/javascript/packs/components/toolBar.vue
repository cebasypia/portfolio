<template>
  <div>
    <v-footer id="footer" app color="amber darken-2" dark>
      <v-icon>mdi-school</v-icon>

      <v-spacer></v-spacer>

      <router-link v-bind:to="{ name: 'TweetsIndexPage' }">
        <v-icon>mdi-home</v-icon>
      </router-link>

      <v-spacer></v-spacer>

      <router-link v-bind:to="{ name: 'TweetsSearchPage' }">
        <v-icon>mdi-magnify</v-icon>
      </router-link>
    </v-footer>
  </div>
</template>

<script></script>

<style scoped>
a {
  text-decoration: none;
}
footer {
  height: 56px;
}
</style>
