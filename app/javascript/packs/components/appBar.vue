<template>
  <div>
    <v-app-bar app hide-on-scroll color="amber darken-2" dark>
      <v-app-bar-nav-icon @click="drawer = true">
        <v-icon>mdi-account</v-icon>
      </v-app-bar-nav-icon>

      <v-spacer></v-spacer>

      <v-toolbar-title @click="scrollTop">Let</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-icon>mdi-logout</v-icon>
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" absolute temporary>
      <v-list nav dense>
        <v-list-item>
          <v-list-item-icon>
            <v-icon>mdi-home</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Home</v-list-item-title>
        </v-list-item>

        <v-list-item>
          <v-list-item-icon>
            <v-icon>mdi-account</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Account</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </div>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
  }),
  methods: {
    scrollTop: function () {
      window.scrollTo({
        top: 0,
        behavior: 'smooth',
      })
    },
  },
}
</script>

<style scoped></style>
