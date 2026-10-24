package file

import "core:os"
import "core:log"

read_file :: proc(path: string) -> []byte {
    is_file := os.is_file(path)
    if !is_file {
        log.fatal("Path provided is not for a file or file does not exist")
        return nil
    }

    file, err := os.open(path)
    if  err != nil {
        log.fatal("Was not possible to read the file")
        return nil
    }
    defer os.close(file)

    data, data_err := os.read_entire_file_from_file(file, context.allocator)
    if data_err != nil {
        if data_err == .EOF {
            log.fatalf("File is empty")
            return nil
        }
        log.fatalf("An error ocurred reading the file: \n %v", err)
        return nil
    }
    return data
}
