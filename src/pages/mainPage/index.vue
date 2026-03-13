<script setup lang="ts">
import { Text } from "@/shared/ui";

const message = "Hello, World!";
</script>

<template>
  <Text :msg="message" />
</template>