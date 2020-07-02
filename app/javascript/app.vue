<template>
  <v-app>
    <AppBar></AppBar>
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>
</template>

<script>
import AppBar from "./packs/components/appBar.vue";

export default {
  components: {
    AppBar,
  },
};
</script>

<style scoped></style>
