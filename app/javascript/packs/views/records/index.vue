<template>
  <v-tabs fixed-tabs light color="amber darken-2">
    <v-tab>みんなのよんだ！</v-tab>
    <v-tab>みんなのかいた！</v-tab>
    <v-tab-item>
      <v-container fluid>
        <ReadCard v-for="read in reads" :read="read" :key="read.id"></ReadCard>
      </v-container>
    </v-tab-item>
    <v-tab-item>
      <v-container fluid>
        <CommentCard
          v-for="comment in comments"
          :comment="comment"
          :key="comment.id"
          :display_delete="false"
        ></CommentCard>
      </v-container>
    </v-tab-item>
  </v-tabs>
</template>

<script>
import axios from 'axios'
import ReadCard from '../../components/reads/card.vue'
import CommentCard from '../../components/comments/card.vue'

export default {
  data: function () {
    return {
      reads: {},
      comments: {},
    }
  },
  mounted() {
    axios
      .get(`/api/v1/reads.json`)
      .then((response) => (this.reads = response.data))
    axios
      .get(`/api/v1/comments.json`)
      .then((response) => (this.comments = response.data))
  },
  methods: {},
  components: {
    ReadCard,
    CommentCard,
  },
}
</script>

<style scoped></style>
