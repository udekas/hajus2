<script setup lang="ts">
import { useForm } from '@inertiajs/vue3';
import AppLayout from '@/layouts/AppLayout.vue';

const form = useForm({
  title: '',
  description: '',
  image: '',
  director: '',
  release_year: '',
});

const submit = () => {
  form.post('/movies', {
    onSuccess: () => form.reset(),
  });
};
</script>

<template>
  <AppLayout>
    <div class="max-w-3xl mx-auto p-8 bg-gradient-to-br from-blue-50 to-white rounded-2xl shadow-xl mt-10">
      <h1 class="text-4xl font-extrabold mb-8 text-blue-700 text-center drop-shadow">Add New Movie</h1>
      <form @submit.prevent="submit" class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div class="col-span-2">
          <label class="block mb-2 font-semibold text-blue-800">Title</label>
          <input
            v-model="form.title"
            type="text"
            class="w-full border-2 border-blue-200 focus:border-blue-500 p-3 rounded-lg transition"
            required
            placeholder="Movie Title"
          />
        </div>

        <div class="col-span-2">
          <label class="block mb-2 font-semibold text-blue-800">Description</label>
          <textarea
            v-model="form.description"
            rows="4"
            class="w-full border-2 border-blue-200 focus:border-blue-500 p-3 rounded-lg transition resize-none"
            required
            placeholder="Brief description of the movie"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-blue-800">Image URL</label>
          <input
            v-model="form.image"
            type="url"
            class="w-full border-2 border-blue-200 focus:border-blue-500 p-3 rounded-lg transition"
            placeholder="https://example.com/image.jpg"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-blue-800">Director</label>
          <input
            v-model="form.director"
            type="text"
            class="w-full border-2 border-blue-200 focus:border-blue-500 p-3 rounded-lg transition"
            required
            placeholder="Director's Name"
          />
        </div>

        <div>
          <label class="block mb-2 font-semibold text-blue-800">Release Year</label>
          <input
            v-model="form.release_year"
            type="number"
            min="0"
            class="w-full border-2 border-blue-200 focus:border-blue-500 p-3 rounded-lg transition"
            required
            placeholder="e.g. 2024"
          />
        </div>

        <div class="col-span-2 flex justify-end mt-4">
          <button
            type="submit"
            class="bg-gradient-to-r from-blue-600 to-blue-400 text-white px-8 py-3 rounded-lg font-bold shadow hover:from-blue-700 hover:to-blue-500 transition disabled:opacity-60"
            :disabled="form.processing"
          >
            <span v-if="form.processing" class="animate-spin mr-2 inline-block align-middle">
              <svg class="w-5 h-5 text-white" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
              </svg>
            </span>
            Save Movie
          </button>
        </div>
      </form>
    </div>
  </AppLayout>
</template>
