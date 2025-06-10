<script setup lang="ts">

import InputError from '@/components/InputError.vue';
import Button from '@/components/ui/button/Button.vue';
import Card from '@/components/ui/card/Card.vue';
import CardContent from '@/components/ui/card/CardContent.vue';
import CardDescription from '@/components/ui/card/CardDescription.vue';
import CardFooter from '@/components/ui/card/CardFooter.vue';
import CardHeader from '@/components/ui/card/CardHeader.vue';
import CardTitle from '@/components/ui/card/CardTitle.vue';
import Input from '@/components/ui/input/Input.vue';
import Label from '@/components/ui/label/Label.vue';
import Textarea from '@/components/ui/textarea/Textarea.vue';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { useForm } from '@inertiajs/vue3';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Create post',
        href: '/posts/create',
    },
];

const form = useForm({
    title: '',
    description: ''
});

const submit = () => {
    form.post(route('posts.store'), {
        onSuccess: () => {
            form.reset();
        },
        onError: () => {
            console.log('error');
        },
    });
};

</script>

<template>
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="my-12 mx-auto w-full max-w-2xl">
            <form @submit.prevent="submit">
                <Card>
                    <CardHeader>
                        <CardTitle>
                            <span class="text-2xl font-bold text-gray-800">Create Post</span>
                        </CardTitle>
                        <CardDescription>
                            <span class="text-gray-500">Fill in the details below to create a new blog post.</span>
                        </CardDescription>
                    </CardHeader>
                    <CardContent class="flex flex-col gap-6">
                        <div>
                            <Label class="block mb-1 text-sm font-medium text-gray-700">Title</Label>
                            <Input
                                v-model="form.title"
                                class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                                placeholder="Enter post title"
                            />
                            <InputError :message="form.errors.title" class="mt-1" />
                        </div>
                        <div>
                            <Label class="block mb-1 text-sm font-medium text-gray-700">Description</Label>
                            <Textarea
                                v-model="form.description"
                                class="w-full px-4 py-2 border rounded min-h-[120px] focus:outline-none focus:ring-2 focus:ring-blue-500"
                                placeholder="Write your post description..."
                            />
                            <InputError :message="form.errors.description" class="mt-1" />
                        </div>
                    </CardContent>
                    <CardFooter class="flex justify-end">
                        <Button
                            type="submit"
                            class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 transition"
                            :disabled="form.processing"
                        >
                            {{ form.processing ? 'Submitting...' : 'Submit' }}
                        </Button>
                    </CardFooter>
                </Card>
            </form>
        </div>
    </AppLayout>
</template>