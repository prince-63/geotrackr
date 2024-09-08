// Utility function to convert '90d' to milliseconds
export function parseDuration(duration) {
    if (!duration) {
        throw new Error('Duration is undefined');
    }
    const match = duration.match(/^(\d+)([dhms])$/);
    if (!match) {
        throw new Error('Invalid duration format');
    }
    const value = parseInt(match[1], 10);
    const unit = match[2];
    switch (unit) {
        case 'd':
            return value * 24 * 60 * 60 * 1000;
        case 'h':
            return value * 60 * 60 * 1000;
        case 'm':
            return value * 60 * 1000;
        case 's':
            return value * 1000;
        default:
            throw new Error('Invalid duration unit');
    }
}
