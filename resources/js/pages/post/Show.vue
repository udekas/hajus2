<script setup lang="ts">
import Button from '@/components/ui/button/Button.vue';
import Textarea from '@/components/ui/textarea/Textarea.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { useForm, usePage } from '@inertiajs/vue3';

const props = defineProps(['post']);
const user = usePage().props.auth.user;

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Show post',
        href: '/posts/show',
    },
];

const form = useForm({
    content: '',
    post_id: props.post.id
});


const submit = () => {
    form.post(route('comments.store', props.post.id), {
        preserveScroll: true,
        onSuccess: () => form.reset()
    });
};

const canDelete = (comment: any) => {
    return user && (user.id === comment.user_id || user.is_admin);
};

const deleteComment = (id: number) => {
    if (confirm('Oled kindel, et soovid kommentaari kustutada?')) {
        form.delete(route('comments.destroy', id), {
            preserveScroll: true
        });
    }
};

const minutesAgo = (dateStr: string): string => {
    const minutes = Math.max(0, Math.floor((new Date().getTime() - new Date(dateStr).getTime()) / 60000));
    return minutes === 0 ? 'just now' : `${minutes} min tagasi`;
};
</script>

<template>
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="my-12 mx-auto w-full max-w-2xl space-y-8">
            <!-- Post details -->
            <div class="bg-white rounded-lg shadow p-6">
                <h1 class="text-3xl font-bold text-gray-800">{{ post.title }}</h1>
                <p class="mt-3 text-gray-600">{{ post.description }}</p>
            </div>

            <!-- Comment form -->
            <form @submit.prevent="submit" class="bg-white rounded-lg shadow p-6">
                <div class="relative">
                    <Textarea
                        v-model="form.content"
                        class="w-full h-24 resize-none border-gray-300 focus:border-blue-400 focus:ring focus:ring-blue-100 rounded-lg px-4 py-3 text-gray-800"
                        placeholder="Lisa kommentaar..."
                    />
                    <div class="flex justify-end mt-3">
                        <Button class="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-5 py-2 rounded-lg shadow transition">
                            Postita
                        </Button>
                    </div>
                </div>
            </form>

            <!-- Comments -->
            <div class="bg-white rounded-lg shadow p-6">
                <h2 class="text-xl font-semibold mb-4 text-gray-800">Kommentaarid</h2>
                <ul>
                    <li
                        v-for="comment in [...post.comments]"
                        :key="comment.id"
                        class="border-b last:border-b-0 py-4 flex justify-between items-start gap-4"
                    >
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-1">
                                <span class="text-sm font-semibold text-blue-700">{{ comment.user.name }}</span>
                                <span class="text-xs text-gray-400">• {{ minutesAgo(comment.created_at) }}</span>
                            </div>
                            <p class="text-gray-700 mb-1">{{ comment.body }}</p>
                        </div>
                        <button
                            v-if="canDelete(comment)"
                            @click="deleteComment(comment.id)"
                            class="text-red-500 text-xs font-medium hover:underline transition"
                            title="Kustuta kommentaar"
                        >
                            Kustuta
                        </button>
                    </li>
                    <li v-if="!post.comments.length" class="text-gray-400 text-center py-6">
                        Kommentaare veel pole.
                    </li>
                </ul>
            </div>
        </div>
    </AppLayout>
</template>
