import z from 'zod';
import { FastifyTypedInstance } from "./types";
import { randomUUID } from 'node:crypto';

interface User {
    id: string
    name: string
    email: string
}

const users = []

export async function routes(app: FastifyTypedInstance) {
    app.get('/users', {
        schema: {
            tags: ['users'],
            description:'Listar Usuários',
        },
    },  () => {
        return []
    })


    app.post('/users', {
        schema: {
            tags: ['users'],
            description: 'Criar novo usuário',
            body: z.object({
                name: z.string(),
                email: z.string().email(),
            }),
        }
    }, (request, reply) => {
        const {name, email} = request.body

        users.push({
            id: randomUUID(),
            name,
            email,
        })

        return reply.status(201).send();
    })
}