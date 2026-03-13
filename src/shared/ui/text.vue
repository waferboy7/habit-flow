<script setup lang="ts">
defineProps<{ msg: string }>();
</script>

<template>
  <p class="main__text">{{ msg }}</p>
</template>

<style scoped>
.main__text {
  font-size: 48px;
  color: #14a37f;
  text-align: center;
  letter-spacing: 10px;
  text-transform: uppercase;
}
</style>