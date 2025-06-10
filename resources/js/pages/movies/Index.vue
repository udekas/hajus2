<script setup lang="ts">
import { ref, computed } from 'vue';
import { Link } from '@inertiajs/vue3';
import AppLayout from '@/layouts/AppLayout.vue';
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle
} from '@/components/ui/card';

interface Movie {
  id: number;
  title: string;
  description: string;
  image: string;
  director?: string;
  release_year?: number;
  developer?: string;
  genres?: string[];
}

const props = defineProps<{
  movies: Movie[],
  externalMovies: Movie[]
}>();

const search = ref('');

const filteredLocal = computed(() => {
  if (!search.value) return props.movies;
  return props.movies.filter(movie =>
    movie.title.toLowerCase().includes(search.value.toLowerCase())
  );
});

const filteredExternal = computed(() => {
  if (!search.value) return props.externalMovies;
  return props.externalMovies.filter(movie =>
    movie.title.toLowerCase().includes(search.value.toLowerCase())
  );
});
</script>

<template>
  <AppLayout>
    <div class="p-6 bg-gradient-to-br from-blue-50 to-purple-100 min-h-screen">
      <!-- Header -->
      <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-extrabold text-gray-800 tracking-tight drop-shadow">
          <span class="inline-block align-middle mr-2">🎬</span>Movies
        </h1>
        <Link
          href="/movies/create"
          class="bg-gradient-to-r from-blue-600 to-purple-600 text-white px-6 py-2 rounded-lg shadow hover:from-blue-700 hover:to-purple-700 transition font-semibold"
        >
          + Add New Movie
        </Link>
      </div>

      <!-- Search -->
      <div class="mb-10 flex justify-center">
        <input
          v-model="search"
          type="text"
          placeholder="🔍 Search by title..."
          class="w-full max-w-lg p-3 border border-gray-300 rounded-xl shadow focus:outline-none focus:ring-2 focus:ring-blue-400 bg-white text-lg"
        />
      </div>

      <!-- Local Movies -->
      <h2 class="text-2xl font-bold mb-3 text-blue-700 flex items-center gap-2">
        <span>🎞️</span>Your Movies
      </h2>
      <div v-if="filteredLocal.length === 0" class="text-gray-500 mb-8 text-center italic">No local movies found.</div>
      <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8 mb-12">
        <Card
          v-for="movie in filteredLocal"
          :key="'local-' + movie.id"
          class="h-full flex flex-col bg-white rounded-2xl shadow-lg hover:shadow-2xl transition"
        >
          <CardHeader class="p-4 pb-2">
            <img
              :src="movie.image"
              alt="Movie image"
              class="w-full h-48 object-cover rounded-xl mb-4 border-2 border-blue-200 shadow"
            />
            <CardTitle class="text-xl font-bold text-gray-800 mb-1">
              {{ movie.title }}
            </CardTitle>
            <CardDescription class="text-gray-600 text-sm mb-2 line-clamp-2">
              {{ movie.description }}
            </CardDescription>
            <div class="flex flex-col gap-1 text-sm text-gray-700">
              <span><strong>Director:</strong> {{ movie.director || 'Unknown' }}</span>
              <span><strong>Year:</strong> {{ movie.release_year || 'N/A' }}</span>
            </div>
          </CardHeader>
        </Card>
      </div>

      <!-- External Movies -->
      <h2 class="text-2xl font-bold mb-3 text-purple-700 flex items-center gap-2">
        <span>🌐</span>Content of Others
      </h2>
      <div v-if="filteredExternal.length === 0" class="text-gray-500 text-center italic">No external movies found.</div>
      <div v-else class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-8">
        <Card
          v-for="movie in filteredExternal"
          :key="'external-' + movie.id"
          class="h-full flex flex-col bg-white rounded-2xl shadow-lg hover:shadow-2xl transition"
        >
          <CardHeader class="p-4 pb-2">
            <img
              :src="movie.image"
              alt="External Movie image"
              class="w-full h-48 object-cover rounded-xl mb-4 border-2 border-purple-200 shadow"
            />
            <CardTitle class="text-xl font-bold text-gray-800 mb-1">
              {{ movie.title }}
            </CardTitle>
            <CardDescription class="text-gray-600 text-sm mb-2 line-clamp-2">
              {{ movie.description }}
            </CardDescription>
            <div class="flex flex-col gap-1 text-sm text-gray-700">
              <span v-if="movie.developer"><strong>Developer:</strong> {{ movie.developer }}</span>
              <span v-if="movie.genres"><strong>Genres:</strong> {{ movie.genres.join(', ') }}</span>
            </div>
          </CardHeader>
        </Card>
      </div>
    </div>
  </AppLayout>
</template>
