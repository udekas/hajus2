<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import Button from '@/components/ui/button/Button.vue';
import { BreadcrumbItem } from '@/types';
import { useForm, Head } from '@inertiajs/vue3';

const props = defineProps<{
  post: {
    id: number;
    title: string;
    description: string;
    created_at_for_humans: string;
  };
}>();

const breadcrumbs: BreadcrumbItem[] = [
  { title: 'Posts', href: '/posts' },
  { title: 'Muuda postitust', href: `/posts/${props.post.id}/edit` },
];

const form = useForm({
  title: props.post.title,
  description: props.post.description,
});

const submit = () => {
  form.put(route('posts.update', props.post.id));
};
</script>

<template>
  <Head title="Muuda postitust" />
  <AppLayout :breadcrumbs="breadcrumbs">
    <div class="my-16 mx-auto w-full max-w-2xl bg-white rounded-xl shadow-lg p-10 space-y-8">
      <h1 class="text-3xl font-bold text-gray-800 mb-4 text-center">Muuda postitust</h1>

      <form @submit.prevent="submit" class="space-y-7">
        <div>
          <label for="title" class="block text-base font-medium text-gray-700 mb-2">Pealkiri</label>
          <input
            id="title"
            v-model="form.title"
            class="w-full rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-100 px-4 py-3 transition duration-150 ease-in-out shadow-sm"
            :class="{ 'border-red-500 ring-red-100': form.errors.title }"
            placeholder="Sisesta pealkiri"
          />
          <p v-if="form.errors.title" class="text-red-500 text-sm mt-2">{{ form.errors.title }}</p>
        </div>

        <div>
          <label for="description" class="block text-base font-medium text-gray-700 mb-2">Kirjeldus</label>
          <textarea
            id="description"
            v-model="form.description"
            rows="6"
            class="w-full rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-100 px-4 py-3 transition duration-150 ease-in-out shadow-sm resize-none"
            :class="{ 'border-red-500 ring-red-100': form.errors.description }"
            placeholder="Sisesta kirjeldus"
          ></textarea>
          <p v-if="form.errors.description" class="text-red-500 text-sm mt-2">{{ form.errors.description }}</p>
        </div>

        <div class="flex justify-end">
          <Button type="submit" class="px-6 py-2 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold shadow transition">
            Salvesta
          </Button>
        </div>
      </form>
    </div>
  </AppLayout>
</template>
