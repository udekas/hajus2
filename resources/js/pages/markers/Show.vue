<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';

const props = defineProps<{
  marker: {
    id: number;
    name: string;
    description: string;
    latitude: number;
    longitude: number;
  }
}>();

const breadcrumbs = [
  { title: 'Markerid', href: '/markers' },
  { title: props.marker.name, href: `/markers/${props.marker.id}` },
];
</script>

<template>
  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="max-w-xl mx-auto bg-white rounded-lg shadow-md p-8 mt-8">
      <h1 class="text-3xl font-extrabold text-gray-800 mb-6 text-center">{{ props.marker.name }}</h1>
      <div class="space-y-4">
        <div class="flex items-center">
          <span class="w-32 font-semibold text-gray-600">Kirjeldus:</span>
          <span class="text-gray-800">{{ props.marker.description }}</span>
        </div>
        <div class="flex items-center">
          <span class="w-32 font-semibold text-gray-600">Laiuskraad:</span>
          <span class="text-gray-800">{{ props.marker.latitude }}</span>
        </div>
        <div class="flex items-center">
          <span class="w-32 font-semibold text-gray-600">Pikkuskraad:</span>
          <span class="text-gray-800">{{ props.marker.longitude }}</span>
        </div>
      </div>
      <div class="mt-8 flex justify-end">
        <a
          :href="`/markers/${props.marker.id}/edit`"
          class="inline-block px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition"
        >
          Muuda
        </a>
      </div>
    </div>
  </AppLayout>
</template>
