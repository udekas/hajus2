<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { useForm } from '@inertiajs/vue3';

const props = defineProps<{
  marker: {
    id: number,
    name: string,
    description: string,
    latitude: number,
    longitude: number,
  }
}>();

const form = useForm({
  name: props.marker.name,
  description: props.marker.description,
  latitude: props.marker.latitude,
  longitude: props.marker.longitude,
});

function submit() {
  form.put(`/markers/${props.marker.id}`);
}

const breadcrumbs = [
  { title: 'Markerid', href: '/markers' },
  { title: 'Muuda', href: `/markers/${props.marker.id}/edit` },
];
</script>

<template>
  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="max-w-xl mx-auto bg-white shadow-lg rounded-lg p-8 mt-8">
      <h1 class="text-2xl font-extrabold mb-6 text-gray-800 text-center">Muuda markerit</h1>
      <form @submit.prevent="submit" class="space-y-6">
        <div>
          <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Nimi:</label>
          <input
            id="name"
            v-model="form.name"
            type="text"
            class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
          />
        </div>

        <div>
          <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Kirjeldus:</label>
          <textarea
            id="description"
            v-model="form.description"
            rows="3"
            class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400 resize-none"
          />
        </div>

        <div class="flex space-x-4">
          <div class="flex-1">
            <label for="latitude" class="block text-sm font-medium text-gray-700 mb-1">Laiuskraad:</label>
            <input
              id="latitude"
              v-model="form.latitude"
              type="number"
              step="any"
              class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
            />
          </div>
          <div class="flex-1">
            <label for="longitude" class="block text-sm font-medium text-gray-700 mb-1">Pikkuskraad:</label>
            <input
              id="longitude"
              v-model="form.longitude"
              type="number"
              step="any"
              class="w-full border border-gray-300 rounded px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"
            />
          </div>
        </div>

        <div class="flex justify-end">
          <button
            type="submit"
            class="bg-blue-600 hover:bg-blue-700 transition text-white font-semibold px-6 py-2 rounded shadow"
          >
            Salvesta
          </button>
        </div>
      </form>
    </div>
  </AppLayout>
</template>
