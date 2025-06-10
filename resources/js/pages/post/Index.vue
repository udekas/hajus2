<script setup lang="ts">
import {
    AlertDialog,
    AlertDialogCancel,
    AlertDialogContent,
    AlertDialogDescription,
    AlertDialogFooter,
    AlertDialogHeader,
    AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import Button from '@/components/ui/button/Button.vue';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { router, Link } from '@inertiajs/vue3';
import { ref } from 'vue';

defineProps(['posts']);

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Posts', href: '/posts' },
];

const posttoDelete = ref<number | null>(null);

const confirmDelete = (id: number) => {
    posttoDelete.value = id;
};

const deletePost = () => {
    if (!posttoDelete.value) return;

    router.delete(route('posts.destroy', posttoDelete.value), {
        preserveScroll: true,
        onSuccess: () => {
            posttoDelete.value = null;
        },
        onError: (errors) => {
            console.error('Kustutamine ebaõnnestus', errors);
        },
    });
};
</script>

<template>
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="mx-auto my-16 w-full max-w-4xl space-y-10">
            <div class="flex justify-between items-center pb-4 border-b">
                <h1 class="tracking-wide text-3xl font-bold text-gray-800">Posts</h1>
                <Link :href="route('posts.create')">
                    <Button class="bg-green-600 hover:bg-green-700 text-white shadow-md px-5 py-2 rounded-md">
                        <span class="inline-flex items-center gap-2">
                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/>
                            </svg>
                            Add new
                        </span>
                    </Button>
                </Link>
            </div>

            <div class="rounded-lg border border-gray-200 shadow-lg bg-white overflow-hidden">
                <Table>
                    <TableHeader>
                        <TableRow class="bg-gray-50">
                            <TableHead class="font-bold text-gray-700 py-3 px-4">Title</TableHead>
                            <TableHead class="font-bold text-gray-700 py-3 px-4">Created At</TableHead>
                            <TableHead class="font-bold text-gray-700 py-3 px-4 text-right">Actions</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                        <TableRow v-for="post in posts" :key="post.id" class="hover:bg-gray-50 transition">
                            <TableCell class="py-3 px-4">{{ post.title }}</TableCell>
                            <TableCell class="py-3 px-4 text-gray-500">{{ post.created_at_for_humans }}</TableCell>
                            <TableCell class="py-3 px-4 text-right space-x-2">
                                <Link :href="route('posts.show', post.id)">
                                    <Button class="bg-blue-500 hover:bg-blue-600 text-white border-none shadow-sm" variant="outline" size="sm">
                                        View
                                    </Button>
                                </Link>

                                <template v-if="post.canManage">
                                    <Link :href="route('posts.edit', post.id)">
                                        <Button class="bg-yellow-500 hover:bg-yellow-600 text-white border-none shadow-sm" variant="outline" size="sm">
                                            Edit
                                        </Button>
                                    </Link>
                                    <Button
                                        variant="destructive"
                                        size="sm"
                                        class="bg-red-500 hover:bg-red-600 text-white border-none shadow-sm"
                                        @click="confirmDelete(post.id)"
                                    >
                                        Delete
                                    </Button>
                                </template>
                            </TableCell>
                        </TableRow>
                    </TableBody>
                </Table>
            </div>
        </div>

        <AlertDialog :open="!!posttoDelete" @update:open="posttoDelete = null">
            <AlertDialogContent>
                <AlertDialogHeader>
                    <AlertDialogTitle class="text-lg font-semibold text-red-600">Are you sure?</AlertDialogTitle>
                    <AlertDialogDescription class="text-gray-600">
                        This action will permanently delete the post.
                    </AlertDialogDescription>
                </AlertDialogHeader>
                <AlertDialogFooter>
                    <AlertDialogCancel @click="posttoDelete = null" class="bg-gray-200 hover:bg-gray-300 text-gray-700 px-4 py-2 rounded">
                        Cancel
                    </AlertDialogCancel>
                    <button
                        @click="deletePost"
                        type="button"
                        class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 text-sm font-medium"
                    >
                        Delete
                    </button>
                </AlertDialogFooter>
            </AlertDialogContent>
        </AlertDialog>
    </AppLayout>
</template>
