<template>
  <div>{{ title }}</div>
</template>

<script>
export default {
  data: function () {
    return {
      title: this.$route.meta.title,
    }
  },
}
</script>

<style></style>
